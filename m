Received: from eggs.gnu.org ([2001:4830:134:3::10]:57986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emj9Y-0008Fi-H2
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emj9X-0006dj-Pc
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:46:28 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:37251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emj9X-0006da-KF
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 11:46:27 -0500
Received: by mail-ot0-x232.google.com with SMTP id e64so3242363ote.4
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 08:46:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180216115410.27287-1-kraxel@redhat.com>
References: <20180216115410.27287-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Feb 2018 16:46:06 +0000
Message-ID: <CAFEAcA8sFVaNogiPi1oieY8cvCJjbs4c+tZLtt0Vd2xmTjb-gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Ui 20180216 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 February 2018 at 11:54, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit fb68096da3d35e64c88cd610c1fa42766c58e92a:
>
>   Revert "tests: use memfd in vhost-user-test" (2018-02-13 09:51:52 +0000)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180216-pull-request
>
> for you to fetch changes up to d50f09ff23f5509c05e3883440849b27af051f08:
>
>   ui: extend VNC trottling tracing to SASL codepaths (2018-02-16 12:33:02 +0100)
>
> ----------------------------------------------------------------
> bugfixes for vnc and sdl2
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
