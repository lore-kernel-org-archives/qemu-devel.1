Received: from eggs.gnu.org ([2001:4830:134:3::10]:56883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1yZb-0000Fl-84
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1yZX-0005ed-JR
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:44:07 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:55279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1yZX-0005eM-Cu
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 13:44:03 -0400
Received: by mail-wm0-x22d.google.com with SMTP id i124so7524218wmf.3
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 10:44:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412741304.28261373.1507657333058.JavaMail.zimbra@redhat.com>
References: <20171010171122.9756-1-marcandre.lureau@redhat.com>
	<CAFEAcA8d+UkhOJKovyedTye=8mD0mcbEScHm58RKyCuzYezxqA@mail.gmail.com>
	<1412741304.28261373.1507657333058.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 18:43:41 +0100
Message-ID: <CAFEAcA_oz4eUHPsw_8A5XkZb=U3HxQpMg16SYac-Gt7gVG7zWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/27] vhost-user patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, changpeng liu <changpeng.liu@intel.com>

On 10 October 2017 at 18:42, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> (the printf format errors are pre-existing - I think should be
> addressed in a different series)

Well, they don't currently cause build failures in master, but
they do with this series, so you'll need to include fixes for them
if you want to get your pull request applied :-)

thanks
-- PMM
