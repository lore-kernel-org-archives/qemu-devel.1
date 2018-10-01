Received: from eggs.gnu.org ([2001:4830:134:3::10]:49234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g6xgz-0002JU-La
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g6xgv-0005tV-GM
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:52:53 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:45175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g6xgv-0005tL-Ba
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 08:52:49 -0400
Received: by mail-yw1-f48.google.com with SMTP id v198-v6so538086ywg.12
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 05:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181001092659.19418-1-pbonzini@redhat.com>
	<CAFEAcA9qKJ5N6ZDB4Pa4ZEcnb1r02QXtHjjuxVKF+3Mj4DYTaQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9qKJ5N6ZDB4Pa4ZEcnb1r02QXtHjjuxVKF+3Mj4DYTaQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Mon, 1 Oct 2018 14:52:37 +0200
Message-ID: <CAAdtpL49hrU4pB9ckkTd31or2edbJbyG0roqpw5LtTXwoLxzoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/79] Misc patches for 2018-09-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Oct 1, 2018 at 12:45 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> On 1 October 2018 at 10:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > ----------------------------------------------------------------
> > Now without UTF-8 mojibake.
>
> Looks like you missed one:
>
> [staging c0a3e6c2bf] Merge remote-tracking branch
> 'remotes/bonzini/tags/for-upstream' into staging
>  Date: Mon Oct 1 11:30:41 2018 +0100
>     Suggested-by: Daniel P. Berrang=C3=83=C2=A9 <berrange@redhat.com>
> ERROR: pull request includes tag with UTF-8 error in person name

It seems Paolo wanted to check your pullreq script first ;)

> (commit b59878a1940c3 in your tree, in both the commit message
> and the tag; commit db5910481bb in just the commit message).
