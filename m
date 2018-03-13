Received: from eggs.gnu.org ([2001:4830:134:3::10]:60061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evhUX-00044j-Hl
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evhUW-0000Jl-MF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:49:13 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:41149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evhUW-0000JD-HG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 06:49:12 -0400
Received: by mail-ot0-x234.google.com with SMTP id w38so18443307ota.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 03:49:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180312160014.6804-1-stefanha@redhat.com>
References: <20180312160014.6804-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 10:48:50 +0000
Message-ID: <CAFEAcA_C5x41ZUZPXrk9pF1vLvX9RT0mkupb7Ljn-CqxyKRo+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/5] Tracing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 12 March 2018 at 16:00, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit e4ae62b802cec437f877f2cadc4ef059cc0eca=
76:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2018-03-09 17:28:16 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 73ff061032efa0b260bcd1a177ac89b57a1642d3:
>
>   trace: only permit standard C types and fixed size integer types (2018-=
03-12 11:10:20 +0000)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (3):
>   trace: include filename when printing parser error messages
>   trace: remove use of QEMU specific types from trace probes
>   trace: only permit standard C types and fixed size integer types
>
> Peter Maydell (1):
>   log-for-trace.h: Split out parts of log.h used by trace.h
>
> Stefan Hajnoczi (1):
>   simpletrace: fix timestamp argument type
>

Applied, thanks.

-- PMM
