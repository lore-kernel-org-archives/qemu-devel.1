Received: from eggs.gnu.org ([2001:4830:134:3::10]:51533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXnUi-0001yh-HZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXnUh-0004vU-Oy
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:54:52 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:46221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXnUU-0004tU-3S
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:54:51 -0400
Received: by mail-oi0-x232.google.com with SMTP id h79-v6so15849580oig.13
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 05:54:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625224110.5147-1-ehabkost@redhat.com>
References: <20180625224110.5147-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 13:54:16 +0100
Message-ID: <CAFEAcA-K0_YKNcouHramCbvxv26nBCW9==+uotxz4tqNdj8Zpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Machine queue, 2018-06-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 25 June 2018 at 23:41, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 35e238c9330669882487f9929e0aa97900431853:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180625-pull-request' into staging (2018-06-25 15:25:26 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 08fe68244eb44f3c8ccecd35066eca8392d1345a:
>
>   hw/i386: Deprecate the machine types pc-0.10 and pc-0.11 (2018-06-25 14:10:01 -0300)
>
> ----------------------------------------------------------------
> Machine queue, 2018-06-25
>
> * Don't support --daemonize and --preconfig together
> * Deprecate machine types pc-0.10 and pc-0.11
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
