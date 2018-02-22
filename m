Received: from eggs.gnu.org ([2001:4830:134:3::10]:50631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoroi-0000pL-Ks
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoroc-0000sQ-RR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 09:25:48 -0500
Date: Thu, 22 Feb 2018 15:25:36 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180222142536.2upstkie3wsv5cps@sirius.home.kraxel.org>
References: <1519303376-92875-1-git-send-email-imammedo@redhat.com>
	<1519303376-92875-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519303376-92875-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] acpi: remove unused acpi-dsdt.aml
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org

On Thu, Feb 22, 2018 at 01:42:48PM +0100, Igor Mammedov wrote:
> SeaBIOS blob which is currently shipped with QEMU
> doesn't need acpi-dsdt.aml nor is able to use it
> and code that loaded it QEMU was removed by
> (commit 9fb7aaaf4c "pc: drop external DSDT loading")
> in 2013.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> CC: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
