Received: from eggs.gnu.org ([2001:4830:134:3::10]:53118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiFmx-0007SX-9C
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fiFmu-0002En-4t
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 05:08:55 -0400
References: <20180724200343.13733-1-lbloch@janustech.com>
	<20180724200343.13733-2-lbloch@janustech.com>
	<3edeb663-8e53-ec83-bc19-45a5804d6be3@redhat.com>
	<20180725084928.GB4879@localhost.localdomain>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <ecd2da40-a115-8e06-42cd-25adef81ccd5@janustech.com>
Date: Wed, 25 Jul 2018 12:08:33 +0300
In-Reply-To: <20180725084928.GB4879@localhost.localdomain>
Content-Language: en-GB-large
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/5 for-3.0] A grammar fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

   On 07/25/2018 11:49 AM, Kevin Wolf wrote:

Am 24.07.2018 um 23:00 hat Eric Blake geschrieben:

On 07/24/2018 03:03 PM, Leonid Bloch wrote:

Subject line is rather vague; at a bare minimum, mentioning 'qcow2:' might
be helpful. But the maintainer can improve that. My suggestion:

qcow2: grammar fix for conflicting cache sizing

How about "qcow2: Grammar fix for conflicting cache size options"?

   Already fixed in v4.



Signed-off-by: Leonid Bloch [1]<lbloch@janustech.com>
---
  block/qcow2.c              | 2 +-
  tests/qemu-iotests/103.out | 2 +-

You replaced only one of the two places in the reference output, so 103
fails for me now.

   Thanks! Didn't add the second place by mistake. Will fix in v5.
   Leonid.

Kevin

References

   1. mailto:lbloch@janustech.com
