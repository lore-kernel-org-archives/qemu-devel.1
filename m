Received: from eggs.gnu.org ([2001:4830:134:3::10]:36533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa07K-0002gF-CM
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa07C-0002YL-AK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:47:50 -0400
Received: from mail-pl0-x235.google.com ([2607:f8b0:400e:c01::235]:34242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa07B-0002XE-T1
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 10:47:42 -0400
Received: by mail-pl0-x235.google.com with SMTP id z9-v6so8069033plo.1
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 07:47:41 -0700 (PDT)
Date: Mon, 2 Jul 2018 23:47:38 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180702144738.GS24595@lianli.shorne-pla.net>
References: <20180702135806.7087-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/25] OpenRISC updates for 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>

On Mon, Jul 02, 2018 at 10:57:41PM +0900, Stafford Horne wrote:
> Hello Peter,
> 
> Changes since Richards v3:
>  - Brought into my queue
>  - Fixed the format warnings the print_insn_or1k patch
>  - Added RB's
> 
> Please consider for pull.

Please hold.

Sorry, Richard found one issue with a checkpatch fix I did.  Respinning this.

-Stafford
