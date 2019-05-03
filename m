Received: from eggs.gnu.org ([209.51.188.92]:54092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZi5-0002Pf-4T
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZi0-0008Si-UY
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:02:47 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:44625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMZhx-0008Oa-EW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:02:43 -0400
Received: by mail-ot1-x32d.google.com with SMTP id d10so452056otp.11
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190503004130.8285-1-ehabkost@redhat.com>
In-Reply-To: <20190503004130.8285-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 16:02:24 +0100
Message-ID: <CAFEAcA81mqN6gDcyW1vzsnER-7CMzsdWreZ93X8Z6b2vCL_2pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/19] Python queue, 2019-05-02
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

On Fri, 3 May 2019 at 01:41, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41=
df:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-05-02 12:04:51 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to faf441429adfe5767be52c5dcdb8bc03161d064f:
>
>   configure: automatically pick python3 is available (2019-05-02 21:33:27=
 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2019-05-02
>
> * configure: automatically pick python3 is available
>   (Daniel P. Berrang=C3=A9)
>
> * tests/acceptance (Cleber Rosa, Philippe Mathieu-Daud=C3=A9):
>   * Multi-architecture test support
>   * Multiple arch-specific boot_linux_console test cases
>   * Increase verbosity of avocado by default
>   * docstring improvements
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
