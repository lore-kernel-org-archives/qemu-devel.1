Received: from eggs.gnu.org ([209.51.188.92]:57469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2IUX-0007CM-3s
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2IUW-00005N-GR
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:37:01 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:41712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2IUW-0008WJ-5J
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:37:00 -0500
Received: by mail-ot1-x336.google.com with SMTP id t7so17849476otk.8
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 08:36:59 -0800 (PST)
MIME-Version: 1.0
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
	<CAFEAcA_nb_s-DGQTf3GRMcN+9ke8XKyzf_n9QfpeCcKCoA439A@mail.gmail.com>
	<20190308115810.6f2dq4ub5t55lnih@sirius.home.kraxel.org>
	<CAFEAcA-mvCSZMQzx4N9UgbbEYaDkGGXB64dpnaVG4UacL=LKuA@mail.gmail.com>
	<e9626b6c-9476-7515-9aee-7dd3f75d42fd@redhat.com>
	<862dd329-3544-8cb0-ebd4-d70ccd63584b@redhat.com>
In-Reply-To: <862dd329-3544-8cb0-ebd4-d70ccd63584b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 16:36:46 +0000
Message-ID: <CAFEAcA99dhHKkmYy947moUn_SVPn6HdXwWE+zrvDyp-9UM=OYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Fri, 8 Mar 2019 at 16:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Let's go and do it.  If somebody really wants to do in-tree builds they
> can use --disable-docs.

TBH I'd suggest postponing this to 4.1...

-- PMM
