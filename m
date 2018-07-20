Received: from eggs.gnu.org ([2001:4830:134:3::10]:38056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgcjM-0004OC-O8
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fgcjL-0002PS-DT
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:14:28 -0400
References: <20180712195120.27394-1-sw@weilnetz.de>
	<07226662-e636-2ff7-5cb4-7a64c6020c04@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e932a87f-83b7-dcc8-d2da-33cc68fa47de@redhat.com>
Date: Fri, 20 Jul 2018 16:14:17 -0500
MIME-Version: 1.0
In-Reply-To: <07226662-e636-2ff7-5cb4-7a64c6020c04@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: Fix typos in comments
 (found by codespell)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>, QEMU Developer <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/12/2018 03:32 PM, John Snow wrote:

>> +++ b/block/gluster.c
>> @@ -1326,7 +1326,7 @@ static int qemu_gluster_has_zero_init(BlockDriverState *bs)
>>    * If @start is in a trailing hole or beyond EOF, return -ENXIO.
>>    * If we can't find out, return a negative errno other than -ENXIO.
>>    *
>> - * (Shamefully copied from file-posix.c, only miniscule adaptions.)
>> + * (Shamefully copied from file-posix.c, only minuscule adaptions.)
> 
> Huh!
> 
> Merriam-Webster lists miniscule as a "disputed" spelling of minuscule.
> Dictionary.com simply lists it as an acceptable alternative.
> 
> Anyway, this is a change from something dubiously correct to something
> unambiguously correct, so it's fine.

While at it, I would s/adaptions/adaptations/

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
