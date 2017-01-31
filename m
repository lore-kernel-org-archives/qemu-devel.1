Received: from eggs.gnu.org ([2001:4830:134:3::10]:36810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYWZn-0000kc-Dm
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYWZk-0000bL-Bg
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:26:19 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:29333 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cYWZk-0000b1-19
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:26:16 -0500
References: <20170131112308.54189-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <11742b7f-ab13-6ed2-2431-f7748fc8cf1b@virtuozzo.com>
Date: Tue, 31 Jan 2017 14:26:00 +0300
MIME-Version: 1.0
In-Reply-To: <20170131112308.54189-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: bdrv_invalidate_cache: invalidate
 children first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

v2 missed in topic, sorry for that.

First version was "[PATCH] block: bdrv_invalidate_cache_all: invalidate 
children first"

-- 
Best regards,
Vladimir
