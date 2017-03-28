Received: from eggs.gnu.org ([2001:4830:134:3::10]:52313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csvO2-0005Cj-QJ
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csvO2-0001CA-3Y
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:58:30 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1csvO1-0001BF-SL
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:58:30 -0400
Received: by mail-wm0-x22e.google.com with SMTP id t189so5373357wmt.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 10:58:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DM2PR21MB006077BF2F5F3DDA94E83ABD9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
References: <CAFEAcA_Dwky8Jr+y3JACdK5MVM82syrvzuVktnJF0cyZ-FjY0A@mail.gmail.com>
	<DM2PR21MB006077BF2F5F3DDA94E83ABD9E320@DM2PR21MB0060.namprd21.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 18:58:08 +0100
Message-ID: <CAFEAcA8VHA7_UZamqdaQkxdjgam8xcspwb0HZCVNPV+xLxoeEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-devel mailing list vs DMARC and
 microsoft.com's p=reject policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 28 March 2017 at 18:53, Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:
>> From: Peter Maydell [mailto:peter.maydell@linaro.org]
>>  (1) I could set dmarc_moderation_action=Reject
>>    * this means nobody can subscribe if they've set their dmarc policy
>>      to reject (the "if you don't believe in mailing lists we don't
>>      believe in you" policy).
>
> Clarification: if I've understood correctly, this means nobody can *post*,
> right? The problem arises when I post to the list, not when I subscribed
> (and qemu-devel doesn't require subscription to post).

Yes, you're right. It wouldn't inconvenience mere lurkers at
these domains.

thanks
-- PMM
