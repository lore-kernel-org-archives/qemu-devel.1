Received: from eggs.gnu.org ([2001:4830:134:3::10]:49201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVZgs-00043v-CZ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVZgr-0006Co-IT
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:46:14 -0400
References: <20180613020613.1343-1-jsnow@redhat.com>
	<20180613020613.1343-2-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <61628fba-3414-a8e2-70ce-3ee50374d82a@virtuozzo.com>
Date: Wed, 20 Jun 2018 12:45:59 +0300
MIME-Version: 1.0
In-Reply-To: <20180613020613.1343-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 01/10] qcow2/bitmap: remove redundant
 arguments from bitmap_list_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

13.06.2018 05:06, John Snow wrote:
> We always call it with the same fields of the struct we always pass.
> We can split this out later if we really wind up needing to.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir
