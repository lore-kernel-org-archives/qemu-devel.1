Received: from eggs.gnu.org ([2001:4830:134:3::10]:37276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTRuA-0004th-9C
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTRu6-0005RN-GR
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:03:10 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:41048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTRu6-0005R7-BD
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:03:06 -0400
Received: by mail-ot0-x243.google.com with SMTP id d19-v6so6956932oti.8
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 06:03:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87y3fhjzm0.fsf@dusky.pond.sub.org>
References: <1527186303-192100-1-git-send-email-mst@redhat.com>
	<1527186303-192100-2-git-send-email-mst@redhat.com>
	<87y3fhjzm0.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Jun 2018 14:02:45 +0100
Message-ID: <CAFEAcA-XWQtxnO2zRf0hF-iGihA4rF-LrHHvqwp-x_Zt68ax2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 1/3] osdep: add wait.h compat macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "Emilio G. Cota" <cota@braap.org>, Max Reitz <mreitz@redhat.com>

On 14 June 2018 at 13:56, Markus Armbruster <armbru@redhat.com> wrote:
> Suggest to drop the last sentence from the comment, and have the commit
> message state you're providing a stub.

This patch is already in upstream, commit 28012e190e68...

thanks
-- PMM
