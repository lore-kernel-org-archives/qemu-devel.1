Received: from eggs.gnu.org ([2001:4830:134:3::10]:56883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=86102624d=anthony.perard@citrix.com>)
	id 1gRHs1-00066l-KD
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=86102624d=anthony.perard@citrix.com>)
	id 1gRHrx-0006zu-TK
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:28:17 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:51902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=86102624d=anthony.perard@citrix.com>)
	id 1gRHrw-0006vv-0X
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:28:13 -0500
Date: Mon, 26 Nov 2018 14:27:39 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181126142739.GK2448@perard.uk.xensource.com>
References: <20181123153040.18933-1-maozhongyi@cmss.chinamobile.com>
	<20181123153040.18933-21-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181123153040.18933-21-maozhongyi@cmss.chinamobile.com>
Subject: Re: [Qemu-devel] [PATCH v2 20/21] xen_backend: remove
 xen_sysdev_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, xen-devel@lists.xenproject.org, peter.maydell@linaro.org, Zhang Shengju <zhangshengju@cmss.chinamobile.com>

On Fri, Nov 23, 2018 at 11:30:39PM +0800, Mao Zhongyi wrote:
> The init function doesn't do anything at all, so we
> just omit it.
> 
> Cc: sstabellini@kernel.org
> Cc: anthony.perard@citrix.com
> Cc: xen-devel@lists.xenproject.org
> Cc: peter.maydell@linaro.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
