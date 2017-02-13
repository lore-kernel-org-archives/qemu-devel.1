Received: from eggs.gnu.org ([2001:4830:134:3::10]:40808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cdJSG-00031P-86
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:26:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marex@denx.de>) id 1cdJSB-0004tu-SD
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:26:20 -0500
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1]:43658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marex@denx.de>) id 1cdJSB-0004ta-Lm
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 11:26:15 -0500
References: <1486947403-22548-1-git-send-email-juro.bystricky@intel.com>
From: Marek Vasut <marex@denx.de>
Message-ID: <c84ee92b-6923-a808-1267-1438bd709c7b@denx.de>
Date: Mon, 13 Feb 2017 16:57:48 +0100
MIME-Version: 1.0
In-Reply-To: <1486947403-22548-1-git-send-email-juro.bystricky@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] nios2: Add Altera JTAG UART emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juro Bystricky <juro.bystricky@intel.com>, qemu-devel@nongnu.org
Cc: crwulff@gmail.com, jurobystricky@hotmail.com, fred.konrad@greensocs.com

On 02/13/2017 01:56 AM, Juro Bystricky wrote:
> Add the Altera JTAG UART model.
> 
> Hardware emulation based on:
> https://www.altera.com/en_US/pdfs/literature/ug/ug_embedded_ip.pdf
> (Please see "Register Map" on page 65)
> 
> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>

Acked-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
