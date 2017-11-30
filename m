Received: from eggs.gnu.org ([2001:4830:134:3::10]:50743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKMr1-0001Ki-1c
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eKMr0-0002Yh-3W
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 06:18:07 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-16-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4b6abc6d-5b38-8e19-51c6-a6d0065b7251@virtuozzo.com>
Date: Thu, 30 Nov 2017 14:17:53 +0300
MIME-Version: 1.0
In-Reply-To: <20171012185916.22776-16-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 15/20] vdi: Avoid bitrot of debugging
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, jsnow@redhat.com

12.10.2017 21:59, Eric Blake wrote:
> Rework the debug define so that we always get -Wformat checking,
> even when debugging is disabled.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Weil <sw@weilnetz.de>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>



-- 
Best regards,
Vladimir
