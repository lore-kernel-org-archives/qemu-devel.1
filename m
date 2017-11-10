Received: from eggs.gnu.org ([2001:4830:134:3::10]:36010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDEPb-0007XB-4v
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:52:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eDEPW-0000gq-Ak
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:52:19 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36973)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eDEPW-0000ge-6Y
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:52:14 -0500
Date: Fri, 10 Nov 2017 13:52:12 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171110185212.GA30670@flamenco>
References: <cover.1510263731.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1510263731.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH for 2.11 v2 0/2] Xilinx ZCU102 fixes for
 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com, ehabkost@redhat.com, f4bug@amsat.org

On Thu, Nov 09, 2017 at 13:49:30 -0800, Alistair Francis wrote:
> These are two small fixes for 2.11.
> 
> V2:
>  - Update qemu-doc.texi
> 
> Alistair Francis (2):
>   xlnx-zynqmp: Properly support the smp command line option
>   xlnx-zcu102: Add an info message deprecating the EP108

Peter: please do not merge this yet!

Given that these two changes require another patch to be tested,
I am going to include these two patches in an upcoming series
with the required patch added first.

BTW I'll also add my R-b tags plus the max_cpus update for the ep108.

		Emilio
