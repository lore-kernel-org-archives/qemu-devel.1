Received: from eggs.gnu.org ([208.118.235.92]:59815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gf4eq-0004qv-Df
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gf4em-0004nV-HP
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 10:11:40 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181211164317.32893-3-vsementsov@virtuozzo.com>
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
	<20181211164317.32893-3-vsementsov@virtuozzo.com>
Date: Thu, 03 Jan 2019 16:11:20 +0100
Message-ID: <w51ef9tepyf.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/8] qcow2: add separate file for
 threaded data processing functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com, den@openvz.org

On Tue 11 Dec 2018 05:43:11 PM CET, Vladimir Sementsov-Ogievskiy wrote:
> Move compression-on-threads to separate file. Encryption will be in it
> too.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
