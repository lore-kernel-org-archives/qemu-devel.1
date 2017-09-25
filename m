Received: from eggs.gnu.org ([2001:4830:134:3::10]:36897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwVD8-0003OL-U6
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dwVD5-0006WG-Oy
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:22:18 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:2458 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dwVD5-0006VV-Cy
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:22:15 -0400
References: <20170925145526.32690-1-eblake@redhat.com>
	<20170925145526.32690-19-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c0b41e0b-d49f-7974-c824-72456bebda16@virtuozzo.com>
Date: Mon, 25 Sep 2017 18:22:09 +0300
MIME-Version: 1.0
In-Reply-To: <20170925145526.32690-19-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 18/20] qcow2: Switch
 store_bitmap_data() to byte-based iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

25.09.2017 17:55, Eric Blake wrote:
> Reviewed-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>

stupid thunderbird bug always stole my whitespace =(

-- 
Best regards,
Vladimir
