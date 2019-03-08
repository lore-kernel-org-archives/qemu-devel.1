Received: from eggs.gnu.org ([209.51.188.92]:45296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lwhsu.freebsd@gmail.com>) id 1h2EAw-0003en-4L
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lwhsu.freebsd@gmail.com>) id 1h2EAs-0001Rh-4f
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:00:28 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lwhsu.freebsd@gmail.com>)
	id 1h2EAr-0001B4-T2
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 07:00:26 -0500
Received: by mail-yw1-f68.google.com with SMTP id v201so16051147ywa.9
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 04:00:24 -0800 (PST)
MIME-Version: 1.0
References: <1552029641-17223-1-git-send-email-thuth@redhat.com>
	<87ef7hg0qw.fsf@zen.linaroharston>
In-Reply-To: <87ef7hg0qw.fsf@zen.linaroharston>
From: Li-Wen Hsu <lwhsu@freebsd.org>
Date: Fri, 8 Mar 2019 20:00:07 +0800
Message-ID: <CAKBkRUyG_Y3OTmXQDK6nyupq2dZToWRnapiJVTyjj-WZ4guHEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Ed Maste <emaste@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Mar 8, 2019 at 5:43 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Thomas Huth <thuth@redhat.com> writes:
>
> > cirrus-ci.com also has the possibility to run CI tasks on macOS.
> > Since most of the QEMU developers do not have access to macOS yet,
> > let's add a CI pipeline for this operating system here, too.
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Acked-by: Ed Maste <emaste@freebsd.org>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Queued to testing/next, thanks.

Acked-by: Li-Wen Hsu <lwhsu@FreeBSD.org>
