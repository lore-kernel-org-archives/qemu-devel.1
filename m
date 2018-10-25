Received: from eggs.gnu.org ([2001:4830:134:3::10]:39254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFg8p-0007Qv-QP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFg8n-0008B4-EP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:57:39 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-5-crosa@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ba91dc41-3378-459f-48a7-d77534922ded@vivier.eu>
Date: Thu, 25 Oct 2018 14:56:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 04/10] qemu-iotests: fix
 filename containing checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Max Reitz <mreitz@redhat.com>

On 04/10/2018 17:18, Cleber Rosa wrote:
> Commit cce293a2945 moved some functions from common.config to
> common.rc, but the error messages still reference the old file
> location.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied

Thanks,
Laurent
