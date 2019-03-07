Received: from eggs.gnu.org ([209.51.188.92]:59764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1h1zbQ-0002Sl-TH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1h1zbO-0002uR-Ty
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:26:52 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1h1zbM-0002sb-Ve
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:26:50 -0500
Received: by mail-io1-f65.google.com with SMTP id f6so499539iop.3
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 12:26:47 -0800 (PST)
MIME-Version: 1.0
References: <1551695576-13205-1-git-send-email-thuth@redhat.com>
	<a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
In-Reply-To: <a0b53ff0-1ded-2a6e-aa4d-b1f4fcc407c1@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Thu, 7 Mar 2019 15:26:34 -0500
Message-ID: <CAPyFy2AnxWBXjUOWRy7_YpoSFadQBAXRooM+t4g6t6XOaF1XgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Li-Wen Hsu <lwhsu@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Mon, 4 Mar 2019 at 07:11, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 3/4/19 11:32 AM, Thomas Huth wrote:
> > cirrus-ci.com also has the possibility to run CI tasks on macOS.
> > Since most of the QEMU developers do not have access to macOS yet,
> > let's add a CI pipeline for this operating system here, too.
>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: Ed Maste <emaste@freebsd.org>
