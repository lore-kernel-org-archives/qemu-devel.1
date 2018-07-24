Received: from eggs.gnu.org ([2001:4830:134:3::10]:46288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhu1C-0002yv-4m
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhu1B-0002m1-2Y
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:54:10 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhu1A-0002lR-LG
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:54:08 -0400
Received: by mail-oi0-x241.google.com with SMTP id d189-v6so6422765oib.6
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 02:54:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180717195553.9111-19-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
	<20180717195553.9111-19-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jul 2018 10:53:46 +0100
Message-ID: <CAFEAcA_7yZgMaVu6xupzTXq6_4NqSWo6w-X-Y2JtpiYw3m6y5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for 3.0 18/18] tests/tcg: remove runcom
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On 17 July 2018 at 20:55, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The combination of being rather esoteric and needing to support mmap @
> 0 means this only ever worked under translation. It has now regressed
> even further and is no longer useful. Kill it.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
