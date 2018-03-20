Received: from eggs.gnu.org ([2001:4830:134:3::10]:54733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyFZm-0005KW-LY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyFZl-0007ks-MZ
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:37:10 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyFZl-0007kU-H4
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 07:37:09 -0400
Received: by mail-oi0-x243.google.com with SMTP id t16-v6so1018701oih.3
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 04:37:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180319202432.1112431-1-eblake@redhat.com>
References: <20180319202432.1112431-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 11:36:48 +0000
Message-ID: <CAFEAcA9juCn04G2cixAejHO+d-XH4NbDdHzE06qdR-NV0wqu8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/38] QAPI patches for 2018-03-12,
 2.12 softfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 March 2018 at 20:23, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 2c8cfc0b52b5a4d123c26c0b5fdf941be24805=
be:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2018-03-19 11:44:26 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-12-v4
>
> for you to fetch changes up to 02e3092db3f9b84ed6aae54e3b71d4dc4196c7eb:
>
>   qapi: Pass '-u' when doing non-silent diff (2018-03-19 14:58:38 -0500)
>
> since v3:
> silence clang's ubsan warnings about nonportable container_of(NULL)
> [sending only the one changed patch]
>
> ----------------------------------------------------------------
> qapi patches for 2018-03-12, 2.12 softfreeze
>
> - Marc-Andr=C3=A9 Lureau: 0/4 qapi: generate a literal qobject for intros=
pection
> - Max Reitz: 0/7 block: Handle null backing link
> - Daniel P. Berrange: chardev: tcp: postpone TLS work until machine done
> - Peter Xu: 00/23 QMP: out-of-band (OOB) execution support
> - Vladimir Sementsov-Ogievskiy: 0/2 block latency histogram
> - Eric Blake: qapi: Pass '-u' when doing non-silent diff
>

Applied, thanks.

-- PMM
