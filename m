Received: from eggs.gnu.org ([2001:4830:134:3::10]:58563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cHpgF-0001xN-Cl
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cHpgE-00018T-M2
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:23:59 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20161130011851.24696-9-mreitz@redhat.com>
References: <20161130011851.24696-1-mreitz@redhat.com>
	<20161130011851.24696-9-mreitz@redhat.com>
Date: Fri, 16 Dec 2016 11:23:51 +0100
Message-ID: <w51eg185g08.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 08/25] block: Add
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed 30 Nov 2016 02:18:34 AM CET, Max Reitz wrote:
> This is a general function for making a filename that is relative to a
> certain BDS absolute.
>
> It calls bdrv_get_full_backing_filename_from_filename() for now, but
> that will be changed in a follow-up patch.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
