Received: from eggs.gnu.org ([2001:4830:134:3::10]:49149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXlW6-0007H4-Ua
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:20:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXlW4-0004Wc-Tz
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:20:26 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXlW2-0004Ts-Qj
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:20:23 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so5072077otk.1
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 03:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20181213175552.14857-1-wainersm@redhat.com>
	<CAFEAcA86SDLGyqL3rG-fEDFsEj8-nz-Uqn5Mb9EeLqiFPeKZfA@mail.gmail.com>
	<cccf3c43-0e51-bbbc-3676-17286b11ec99@redhat.com>
	<CAFEAcA9CpR=JGt74=xaUddYhf5SCOoeHH_v+O1L+rrTygZ7quQ@mail.gmail.com>
	<860b98f8-02d0-4c96-ccf2-d582ca295b95@redhat.com>
	<871s6kfwoo.fsf@dusky.pond.sub.org>
In-Reply-To: <871s6kfwoo.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 11:20:10 +0000
Message-ID: <CAFEAcA_KP532BBsESjO1NuKSeefSKH7RdpCdSDLfgMCtc6D5nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/1] checkpatch: checker for comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 14 Dec 2018 at 06:29, Markus Armbruster <armbru@redhat.com> wrote:
>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On 13/12/18 19:21, Peter Maydell wrote:
> >> On Thu, 13 Dec 2018 at 18:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>> On 13/12/18 19:01, Peter Maydell wrote:
> >>>> I sent a patch to do this a little while back:
> >>>>  https://patchwork.kernel.org/patch/10561557/

> >>>> Personally I think we should just commit my patch, and then
> >>>> we can stop having people manually pointing out where
> >>>> submitters' patches don't match CODING_STYLE.
>
> Concur.  It has my R-by, modulo a commit message tweak.

I have to admit I never really understood what tweak
you wanted making to the commit message. I'm happy
to make it clearer: do you want to suggest a rewording?

thanks
-- PMM
