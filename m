Received: from eggs.gnu.org ([2001:4830:134:3::10]:55638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn3WB-0004wI-Cu
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn3W5-0000H6-Rn
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:03:27 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180628000745.4477-11-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-11-mreitz@redhat.com>
Date: Tue, 07 Aug 2018 17:03:07 +0200
Message-ID: <w51tvo68bis.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 10/31] block:
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Thu 28 Jun 2018 02:07:24 AM CEST, Max Reitz wrote:
> Make bdrv_get_full_backing_filename_from_filename() return an allocated
> string instead of placing the result in a caller-provided buffer.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
