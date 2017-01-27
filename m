Received: from eggs.gnu.org ([2001:4830:134:3::10]:47903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX7o1-00055X-6j
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cX7nw-0007H4-JN
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:47:13 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:33779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cX7nw-0007Go-F1
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:47:08 -0500
Received: by mail-vk0-x22f.google.com with SMTP id k127so176213511vke.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 06:47:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170126102757.23280-1-berrange@redhat.com>
References: <20170126102757.23280-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 14:46:46 +0000
Message-ID: <CAFEAcA-JsyP3DGxPRBDsRHcEFA3_yUpSTZYkEXPJJc59ZcHa7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v1] Merge io/ 2017/01/26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 January 2017 at 10:27, Daniel P. Berrange <berrange@redhat.com> wrote:
> The following changes since commit c7f1cf01b8245762ca5864e835d84f6677ae8b1f:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into staging (2017-01-25 17:54:14 +0000)
>
> are available in the git repository at:
>
>   git://github.com/berrange/qemu tags/pull-qio-2017-01-26-1
>
> for you to fetch changes up to 80fb34eda099e7cc519a91e9701ab3c0262717b3:
>
>   io: fix possible double free of task error object (2017-01-26 10:26:18 +0000)
>
> ----------------------------------------------------------------
> Merge io/ 2017/01/26
>
> ----------------------------------------------------------------
> Daniel P. Berrange (1):
>   io: fix possible double free of task error object

Applied, thanks.

-- PMM
