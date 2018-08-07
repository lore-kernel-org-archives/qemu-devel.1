Received: from eggs.gnu.org ([2001:4830:134:3::10]:57816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn3aZ-0008D2-3j
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn3aY-0003Jj-A3
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:07:59 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180628000745.4477-13-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-13-mreitz@redhat.com>
Date: Tue, 07 Aug 2018 17:07:51 +0200
Message-ID: <w51o9ee8baw.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 12/31] block: Add
 bdrv_make_absolute_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Thu 28 Jun 2018 02:07:26 AM CEST, Max Reitz wrote:
> This is a general function for making a filename that is relative to a
> certain BDS absolute.
>
> It calls bdrv_get_full_backing_filename_from_filename() for now, but
> that will be changed in a follow-up patch.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
