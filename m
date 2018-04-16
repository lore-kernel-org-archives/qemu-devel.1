Received: from eggs.gnu.org ([2001:4830:134:3::10]:43622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f80NN-0008I4-EE
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:24:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f80NM-0004VE-JS
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:24:41 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f80NM-0004U5-DO
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 05:24:40 -0400
Received: by mail-oi0-x241.google.com with SMTP id 188-v6so13863018oih.8
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 02:24:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180416091845.7315-1-christophe.lyon@st.com>
References: <20180416091845.7315-1-christophe.lyon@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 10:24:19 +0100
Message-ID: <CAFEAcA-FSkoKFe_h8uEqZ+4UdeTsviOpobi4t+VaOBNRFgjXJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add ARM get_tls syscall support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 16 April 2018 at 10:18, Christophe Lyon <christophe.lyon@st.com> wrote:
> Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
> Signed-off-by: Christophe Lyon <christophe.lyon@st.com>


I think it's worth mentioning in the commit message that this
is a new Arm-specific syscall added in kernel version 4.15.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
