Received: from eggs.gnu.org ([2001:4830:134:3::10]:39199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEOxB-00027v-SA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eEOxB-0004Fg-3Y
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 19:19:49 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-8-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <096f0944-6c42-4c56-b219-e3eaf17054ac@redhat.com>
Date: Mon, 13 Nov 2017 19:19:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171030163309.75770-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 07/14] migration: include
 migrate_dirty_bitmaps in migrate_postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com



On 10/30/2017 12:33 PM, Vladimir Sementsov-Ogievskiy wrote:
> Enable postcopy if dirty bitmap migration is endabled.
> 

"enabled"

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
