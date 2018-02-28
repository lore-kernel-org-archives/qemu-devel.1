Received: from eggs.gnu.org ([2001:4830:134:3::10]:33185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1er7Fv-0006Wb-DD
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1er7Fu-00088F-Kq
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 14:19:11 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-20-jsnow@redhat.com>
	<2c7f82a8-8b19-4f2d-b6d5-3c77258edf91@redhat.com>
	<a2ce7907-a3e6-3c3b-fe9b-cd5ee119efe3@redhat.com>
	<20180228182326.GM4855@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <77de1883-4414-57b2-2fa7-72c2ff85ab8c@redhat.com>
Date: Wed, 28 Feb 2018 14:19:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180228182326.GM4855@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 19/21] blockjobs: Expose manual property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 02/28/2018 01:23 PM, Kevin Wolf wrote:
> But given how often I already said that and people still don't consider
> it as an option, this doesn't appear to have been very convincing. So
> whatever... *shrug*
> 

Sorry, I didn't mean to give that impression.

I initially *did* use two (or more?) variables to describe different
points, and I was convinced to collapse it down into one boolean that
meant "new or old" syntax.

I was just hesitant to run out and change it back until further comments
on what the series looked like at the moment.

--js
