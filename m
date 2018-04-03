Received: from eggs.gnu.org ([2001:4830:134:3::10]:53241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1f3NQD-0008SZ-Nc
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1f3NQ8-0007vC-Ej
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:00:29 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:37228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1f3NQ8-0007uJ-3D
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:00:24 -0400
Received: by mail-wr0-f178.google.com with SMTP id l49so19046094wrl.4
	for <qemu-devel@nongnu.org>; Tue, 03 Apr 2018 08:00:23 -0700 (PDT)
Date: Tue, 3 Apr 2018 17:00:20 +0200
From: Sergio Lopez <slp@redhat.com>
Message-ID: <20180403150020.g5rbp3zphgkf7ind@dritchie>
References: <20171229094206.14512-1-slp@redhat.com>
	<CAAiTLFXrMF1pw-rk9UNCcgLYGB48YkMS+2Ft29dzpifw3K-msw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAiTLFXrMF1pw-rk9UNCcgLYGB48YkMS+2Ft29dzpifw3K-msw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] pvpanic: implement abort_on_panic
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org, mjt@tls.msk.ru, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Fri, Jan 12, 2018 at 05:31:58PM +0100, Sergio Lopez wrote:
> On Fri, Dec 29, 2017 at 10:42 AM, Sergio Lopez <slp@redhat.com> wrote:
> > Extend pvpanic and qemu_system_guest_panicked so it's possible to
> > configure the first to induce an abort() when the Guest panics.
> >
> > This is specially useful (and mainly intended to be enabled only) when
> > debugging soft/hard lockups on the Guest OS.
> >
> > Sergio Lopez (2):
> >   vl: extend qemu_system_guest_panicked with abort_on_panic
> >   pvpanic: add PVPANIC_ABORT_PROP
> 
> If someone has a minute, please consider taking a look at this (small)
> patch series.

Pretty pretty please?

Sergio.
