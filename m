Received: from eggs.gnu.org ([2001:4830:134:3::10]:56255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dGMZR-00030a-Ff
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:39:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dGMZQ-0001rU-N4
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:39:09 -0400
Received: from mail-it0-x236.google.com ([2607:f8b0:4001:c0b::236]:38765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roman.penyaev@profitbricks.com>)
	id 1dGMZQ-0001qW-HC
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 05:39:08 -0400
Received: by mail-it0-x236.google.com with SMTP id r63so29312508itc.1
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 02:39:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170530113502.GC27787@lemon.lan>
References: <20170530100736.3338-1-roman.penyaev@profitbricks.com>
	<20170530113502.GC27787@lemon.lan>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Thu, 1 Jun 2017 11:38:47 +0200
Message-ID: <CAJrWOzB8FdDo4e0TKuWRDf+VowWQaNntOGpnpQyZ0J5P_-tgdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] coroutine-lock: do not touch
 coroutine after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, May 30, 2017 at 1:35 PM, Fam Zheng <famz@redhat.com> wrote:
[cut]
> Reviewed-by: Fam Zheng <famz@redhat.com>

Do I need to resend the patch with 'reviewed-by' line?  Or it is
already queued?

--
Roman
