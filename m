Received: from eggs.gnu.org ([2001:4830:134:3::10]:49707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWoIg-0001wu-AJ
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:57:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWoIf-0001rw-Kg
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:57:34 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:33287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWoIf-0001ow-GO
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 12:57:33 -0500
Received: by mail-vk0-x236.google.com with SMTP id k127so159539601vke.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 09:57:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d95139a6-0e38-75b5-b8df-b4e12391e032@redhat.com>
References: <mailman.205.1485450031.31314.qemu-devel@nongnu.org>
	<E8A8BF62-0E39-4401-B330-2E27CFA3A83F@gmail.com>
	<8ae107ad-0f3f-46ef-e734-2f88b14bad9a@redhat.com>
	<265EAA01-0C75-45D5-A55D-481DAC288AE5@gmail.com>
	<d95139a6-0e38-75b5-b8df-b4e12391e032@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Jan 2017 17:57:10 +0000
Message-ID: <CAFEAcA9N41fGAuVScUXOMorKHmvzzOoNKppEP6eniQEivVT_jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Qemu-devel] Poll on QEMU documentation project
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: G 3 <programmingkidx@gmail.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 26 January 2017 at 17:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
> - HTML is mostly a destination format.  With the listed formats it is
> possible to produce a variety of outputs (mostly HTML itself and PDF;
> secondarily text or ePub or others).

It's an interesting question to ask what destination formats
we should be generating, though. At the moment we output
HTML, plain text, PDF and info. Personally I think that list
is too long and we should probably cut it down to HTML
and PDF or perhaps even just HTML.

thanks
-- PMM
