Received: from eggs.gnu.org ([2001:4830:134:3::10]:44895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1clLgf-0005Pk-Gi
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 15:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1clLge-0000We-L0
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 15:26:25 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:36461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1clLge-0000Ut-Gj
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 15:26:24 -0500
Received: by mail-oi0-x22e.google.com with SMTP id 126so8518834oig.3
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 12:26:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170307155054.5833-1-alex.bennee@linaro.org>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 7 Mar 2017 15:25:51 -0500
Message-ID: <CAJhHMCBrwJc_bKf7E0PSnaRdR2U-WA_AO7J1JS_pZPAmOvu8TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/11] MTTCG fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, MTTCG Devel <mttcg@listserver.greensocs.com>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Hi Alex,

On Tue, Mar 7, 2017 at 10:50 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> Hi,
>
> This is the latest iteration of fixes for problems introduced by
> MTTCG. Aside from the usual slew of addressing review comments and
> applying tags I've also pulled in Yongbok Kim's MIPS patch (to replace
> mine) and Paolo's VMEXIT fix for the problem reported by Alexander
> Boettcher.
>
> Unless anyone shouts I'll wrap these up into a pull request for Peter
> tomorrow.


Can you also pick up this patch? I am not sure who else will.

http://patchwork.ozlabs.org/patch/733293/

Thanks,
--=20
Pranith
