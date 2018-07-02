Received: from eggs.gnu.org ([2001:4830:134:3::10]:43604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fa4sL-0005LM-0X
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fa4sH-0002RN-Si
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:52:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fa4sH-0002Ph-KU
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 15:52:37 -0400
Date: Mon, 2 Jul 2018 15:52:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180702195234.GB20840@flamenco>
References: <20180614193147.29680-15-richard.henderson@linaro.org>
	<000601d40f7a$4be320b0$e3a96210$@ru>
	<20180629184832.GB14726@flamenco>
	<000901d411c8$d3bfc9c0$7b3f5d40$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901d411c8$d3bfc9c0$7b3f5d40$@ru>
Subject: Re: [Qemu-devel] [PULL,
 14/18] translate-all: discard TB when tb_link_page returns an
 existing matching TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Richard Henderson' <richard.henderson@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Mon, Jul 02, 2018 at 08:52:14 +0300, Pavel Dovgalyuk wrote:
> The same failure can be reproduced with linux-0.2.img, which was
> downloaded from QEMU site.
> I can't find it now, but I can upload this file if needed.

Please upload it somewhere and share the full QEMU invocation
needed to replicate.

Thanks,

		Emilio
