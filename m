Received: from eggs.gnu.org ([2001:4830:134:3::10]:53060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duKjE-0003i5-8z
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1duKjA-0001HA-T2
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:46:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <a6ad8398-fcef-2d7f-548a-024c54ad2379@virtuozzo.com>
Date: Tue, 19 Sep 2017 18:46:19 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Qemu-devel] image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

Hi Fam!

I have a question about your image locking series:

Can you please explain, why OFD locking is enabled by default and posix 
locking is not? What is wrong with posix locking, what are the problems?

-- 
Best regards,
Vladimir
