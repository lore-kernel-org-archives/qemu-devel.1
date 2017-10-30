Received: from eggs.gnu.org ([2001:4830:134:3::10]:43234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9Ehb-0005Vo-Tt
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9EhY-0004OI-NK
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:22:23 -0400
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <651e3548-13f5-8152-251e-0c7b5a9af365@virtuozzo.com>
Date: Mon, 30 Oct 2017 21:22:12 +0300
MIME-Version: 1.0
In-Reply-To: <20171030163309.75770-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v8 00/14] Dirty bitmaps postcopy migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

30.10.2017 19:32, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>
> There is a new version of dirty bitmap postcopy migration series.
>
> v8
>
> clone: tag postcopy-v8 from https://src.openvz.org/scm/~vsementsov/qemu.git
> online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=postcopy-v8

compilation is broken for s390, so updated version is:

clone: tag postcopy-v8.1 from https://src.openvz.org/scm/~vsementsov/qemu.git
online: https://src.openvz.org/users/vsementsov/repos/qemu/browse?at=postcopy-v8.1



-- 
Best regards,
Vladimir
