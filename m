Received: from eggs.gnu.org ([209.51.188.92]:37194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghB9j-0004Lr-HE
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghB9i-0003Ck-Q5
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:32:15 -0500
References: <20190105023831.66910-1-liq3ea@163.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <733a962f-badf-6586-8fa6-b9e44b2dd7a2@vivier.eu>
Date: Wed, 9 Jan 2019 11:31:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190105023831.66910-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] ioapic: use TYPE_FOO MACRO
 than constant string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-trivial@nongnu.org, lvivier@redhat.com, qemu-devel@nongnu.org

On 05/01/2019 03:38, Li Qiang wrote:
> Make them more QOMConventional.
> Cc:qemu-trivial@nongnu.org
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/i386/kvm/ioapic.c     | 2 +-
>  hw/i386/pc.c             | 4 ++--
>  hw/intc/ioapic.c         | 2 +-
>  include/hw/i386/ioapic.h | 3 +++
>  4 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
