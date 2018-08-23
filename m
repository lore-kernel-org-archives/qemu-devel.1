Received: from eggs.gnu.org ([2001:4830:134:3::10]:56157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fstaU-0007md-Ku
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fstaP-0001wI-Im
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:40:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fstaP-0001uw-09
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:39:57 -0400
References: <20180823164025.12553-1-armbru@redhat.com>
	<20180823164025.12553-59-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <554415b1-07eb-c570-78dc-621496115860@redhat.com>
Date: Thu, 23 Aug 2018 12:39:53 -0500
MIME-Version: 1.0
In-Reply-To: <20180823164025.12553-59-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 58/58] json: Update references to RFC
 7159 to RFC 8259
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/23/2018 11:40 AM, Markus Armbruster wrote:
> RFC 8259 (December 2017) obsoletes RFC 7159 (March 2014).
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/qnum.h | 2 +-
>   qapi/introspect.json    | 2 +-
>   qobject/json-parser.c   | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
