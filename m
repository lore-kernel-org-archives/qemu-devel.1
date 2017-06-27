Received: from eggs.gnu.org ([2001:4830:134:3::10]:58846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPtvQ-0002SN-AH
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPtvP-0005t3-GZ
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:05:16 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:36409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dPtvP-0005sk-CK
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 13:05:15 -0400
Received: by mail-ua0-x242.google.com with SMTP id g40so2667334uaa.3
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 10:05:15 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <149857598110.66.2259618279911881011@4f20b1c0f442>
References: <1498487280-17836-1-git-send-email-peter.maydell@linaro.org>
	<149857598110.66.2259618279911881011@4f20b1c0f442>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Tue, 27 Jun 2017 13:59:58 -0300
Message-ID: <CAAdtpL5F4rNona5qD=FBY4RtOsic+K042wgObayuqXsLBfc5=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] main_loop: Make main_loop_wait() return
 void
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Jun 26, 2017 at 11:28 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
...
On Tue, Jun 27, 2017 at 12:06 PM,  <no-reply@patchew.org> wrote:

36h in the queue?

> /tmp/qemu-test/src/tests/test-char.c: In function =E2=80=98main_loop=E2=
=80=99:
> /tmp/qemu-test/src/tests/test-char.c:29: error: void value not ignored as=
 it ought to be
