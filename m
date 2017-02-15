Received: from eggs.gnu.org ([2001:4830:134:3::10]:46029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ce1TQ-0008Fo-Ju
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ce1TP-0002zy-Re
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:26:28 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:44907 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ce1TP-0002z8-FW
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:26:27 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5fd09f2c-4201-1099-6d1b-a130e688e6eb@virtuozzo.com>
Date: Wed, 15 Feb 2017 18:26:13 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] blockdev-add/del status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Hi all!

What is the status of qmp commands blockdev-add and x-blockdev-del? Is 
blockdev-add stable (it never had x- prefix)? What should be done to get 
rid of "x-" for x-blockdev-del?

I see a lot of work on blockdev-add in the list, but x-blockdev-del 
seems untouched about 8 moths..


-- 
Best regards,
Vladimir
