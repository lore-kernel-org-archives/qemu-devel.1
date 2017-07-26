Received: from eggs.gnu.org ([2001:4830:134:3::10]:55369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daKsT-0002Gt-Nv
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daKsS-00020d-Um
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:53:21 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1daKsS-00020W-O1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:53:20 -0400
Received: by mail-wr0-x230.google.com with SMTP id k71so77036904wrc.2
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 04:53:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170726114437.19624-1-pbonzini@redhat.com>
References: <20170726114437.19624-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Jul 2017 12:52:59 +0100
Message-ID: <CAFEAcA9_fcrXw-H2wgVMTKP3G_A11wMYP3YH+fZ9ub7gXQF2rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [qemu-web PATCH] add Thomas's bug reporting dos
 and don'ts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On 26 July 2017 at 12:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
> We don't want the page to become too long, but these are good suggestions.
>
> Also tone down the sentence about using the latest release or latest git
> tree, though we do prefer those.

>  * Reproduce the problem directly with a QEMU command-line.  Avoid frontends and management stacks, to ensure that the bug is in QEMU itself and not in a frontend.
>
> -* Include as information about the guest (operating system, version, 32/64-bit).
> +* Include as information about the host and guest (operating system, version, 32/64-bit).

I'm not sure what the "as" here is for: should this say just
"Include information" or "Include as much information as possible"
or something else?

thanks
-- PMM
