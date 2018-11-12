Received: from eggs.gnu.org ([2001:4830:134:3::10]:57746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMEKQ-0004hi-Nr
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:40:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMEKD-00062s-08
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:40:35 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181031113418.29796-2-anton.nefedov@virtuozzo.com>
References: <20181031113418.29796-1-anton.nefedov@virtuozzo.com>
	<20181031113418.29796-2-anton.nefedov@virtuozzo.com>
Date: Mon, 12 Nov 2018 16:40:21 +0100
Message-ID: <w51efbqb8yi.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/9] qapi: group BlockDeviceStats fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Wed 31 Oct 2018 12:34:40 PM CET, Anton Nefedov wrote:
> Make the stat fields definition slightly more readable.
> Also reorder total_time_ns stats read-write-flush as done elsewhere.
> Cosmetic change only.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
