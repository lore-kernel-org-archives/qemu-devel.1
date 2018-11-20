Received: from eggs.gnu.org ([2001:4830:134:3::10]:60888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP4LH-0004zw-K6
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gP4LG-0005ns-SB
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:37:19 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:41354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gP4LG-0005ni-O4
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 06:37:18 -0500
Received: by mail-ot1-x32d.google.com with SMTP id u16so1342917otk.8
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 03:37:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1542711143-1946-1-git-send-email-thuth@redhat.com>
References: <1542711143-1946-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Nov 2018 11:36:57 +0000
Message-ID: <CAFEAcA9kZ4VEX11gn5cT24+t4Y3M5ZWtsdLg95tDEpXX2Sq68w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] qtest patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 20 November 2018 at 10:52, Thomas Huth <thuth@redhat.com> wrote:
>  Hi Peter,
>
> the following changes since commit d304cf014bf9feec3dcd7ee65c75a7f52206ecdf:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181119' into staging (2018-11-19 15:58:17 +0000)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2018-11-20
>
> for you to fetch changes up to ced09f9b07e425690d3bfe524cf93c4dbf4b26bc:
>
>   qtest: log QEMU command line (2018-11-20 10:49:12 +0100)
>
> ----------------------------------------------------------------
> - One additional simple qmp-test
> - A fix for ide-test
> - Add logging of QEMU parameters in libqtest
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
