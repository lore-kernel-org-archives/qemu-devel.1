Received: from eggs.gnu.org ([2001:4830:134:3::10]:47037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9AzQ-0004Ux-S6
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1f9AzQ-0005hJ-4l
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:56:48 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180411185425.2461-13-mreitz@redhat.com>
References: <20180411185425.2461-1-mreitz@redhat.com>
	<20180411185425.2461-13-mreitz@redhat.com>
Date: Thu, 19 Apr 2018 16:56:41 +0200
Message-ID: <w51lgdjckie.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 12/13] block/mirror: Add
 copy mode QAPI interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On Wed 11 Apr 2018 08:54:24 PM CEST, Max Reitz wrote:
> This patch allows the user to specify whether to use active or only
> background mode for mirror block jobs.  Currently, this setting will
> remain constant for the duration of the entire block job.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
