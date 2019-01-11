Received: from eggs.gnu.org ([209.51.188.92]:40807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghz0W-0008VX-9L
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghz0V-0000BD-Ey
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:46:04 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:41216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghz0V-0000Al-7A
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:46:03 -0500
Received: by mail-ot1-x32d.google.com with SMTP id u16so13459567otk.8
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 07:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20190110142955.23254-1-ehabkost@redhat.com>
In-Reply-To: <20190110142955.23254-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 15:45:51 +0000
Message-ID: <CAFEAcA9QS-3-4ZP026SJteTMaog1TXe-VJ7mZYnC8EBLsFPO5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/10] Machine queue, 2019-01-10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On Thu, 10 Jan 2019 at 14:29, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 8ae951fbc1068308313b2c57a4fc3c68451641=
f4:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190109=
' into staging (2019-01-09 16:08:31 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to d769f0dfeeaa1554a38fedb16bb20a4b0ecf793c:
>
>   qom: Don't keep error value between object_property_parse() calls (2019=
-01-10 12:25:15 -0200)
>
> ----------------------------------------------------------------
> Machine queue, 2019-01-10
>
> * Simplify GlobalProperty array declarations (Eduardo Habkost)
> * Deprecate cpu-add commands (Kashyap Chamarthy)
> * range/memory-device cleanups (David Hildenbrand)
> * Fix -device scsi-hd,help regression (Marc-Andr=C3=A9 Lureau)
> * Fix crash when -global generates multiple warnings (Eduardo
>   Habkost)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
