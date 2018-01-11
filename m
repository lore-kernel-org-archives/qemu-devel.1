Received: from eggs.gnu.org ([2001:4830:134:3::10]:52750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZghX-0004e5-M6
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eZghW-0004pq-RO
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 12:31:39 -0500
References: <20180110230825.18321-1-eblake@redhat.com>
	<20180110230825.18321-2-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <ddafb761-7661-86dd-82cd-79135013a410@virtuozzo.com>
Date: Thu, 11 Jan 2018 20:31:28 +0300
MIME-Version: 1.0
In-Reply-To: <20180110230825.18321-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/6] nbd/server: Hoist
 nbd_reject_length() earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

11.01.2018 02:08, Eric Blake wrote:
> No semantic change, but will make it easier for an upcoming patch
> to refactor code without having to add forward declarations.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 

Best regards,
Vladimir
