Received: from eggs.gnu.org ([209.51.188.92]:47435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGWXz-0007KO-Go
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGWXx-0005gU-8B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:27:23 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGWXv-0005eX-VU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:27:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id e80so1750076ote.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 15:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190415154503.6758-1-berrange@redhat.com>
	<CAFEAcA-YpG71aGtTVMafShGyd9uM599Uy_8S3vvvnPzfiKMqnw@mail.gmail.com>
	<CAFEAcA-kywfUEZARqzH=obD1p3UsAcsNneK-X0BPpoFnV-QK0A@mail.gmail.com>
	<CAFEAcA_+sf3L5ChBDKEekKb5iTTQZu4mEfF7eiTL78oMDuR16A@mail.gmail.com>
In-Reply-To: <CAFEAcA_+sf3L5ChBDKEekKb5iTTQZu4mEfF7eiTL78oMDuR16A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 23:27:06 +0100
Message-ID: <CAFEAcA84DLEGQduvubsKP-2NrdNkzLcihL2WusZiHReupbF1PA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>

On Tue, 16 Apr 2019 at 20:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 16 Apr 2019 at 18:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Having thought a bit more I think I'd definitely like to apply
> > just patch 2 for 4.0. Could people try to test that and confirm
> > that it at least does not make the feature behave any worse?
>
> I've done a tentative merge test of patch 2, which is OK.
> I'd like to push that either today or tomorrow (uk time):
> objections?

...now pushed.

thanks
-- PMM
