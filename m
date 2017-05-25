Received: from eggs.gnu.org ([2001:4830:134:3::10]:36101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDumC-0004LZ-VA
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dDum9-00068Y-1K
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:34:12 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:13813 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dDum8-00068I-Lu
	for qemu-devel@nongnu.org; Thu, 25 May 2017 11:34:08 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-8-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5161f2cc-7466-bb7e-e8e6-0a9f72add5ad@virtuozzo.com>
Date: Thu, 25 May 2017 18:34:01 +0300
MIME-Version: 1.0
In-Reply-To: <20170525152628.37628-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 7/7] block: rename
 _get_allocated_file_size() to _get_fs_allocated_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

25.05.2017 18:26, Vladimir Sementsov-Ogievskiy wrote:
> To be in contrast with _get_format_allocated_size()


Sorry for broken indents in this patch, I'll fix them in the next 
version. Waiting for other comments.


-- 
Best regards,
Vladimir
