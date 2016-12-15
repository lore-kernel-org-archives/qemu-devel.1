Received: from eggs.gnu.org ([2001:4830:134:3::10]:33996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cHYta-0002k3-5T
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:28:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cHYtZ-0004hd-Eu
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 11:28:38 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20161130011851.24696-7-mreitz@redhat.com>
References: <20161130011851.24696-1-mreitz@redhat.com>
	<20161130011851.24696-7-mreitz@redhat.com>
Date: Thu, 15 Dec 2016 17:28:29 +0100
Message-ID: <w51oa0ddumq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 06/25] block:
 bdrv_get_full_backing_filename_from_...'s ret. val.
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

On Wed 30 Nov 2016 02:18:32 AM CET, Max Reitz wrote:
> Make bdrv_get_full_backing_filename_from_filename() return an allocated
> string instead of placing the result in a caller-provided buffer.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
