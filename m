Received: from eggs.gnu.org ([2001:4830:134:3::10]:40303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDVQK-0007KF-5e
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:34:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fDVQJ-00073d-Cq
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:34:28 -0400
Date: Tue, 1 May 2018 15:34:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180501153411.7ca32d92@redhat.com>
In-Reply-To: <CAFEAcA8iq9gJuC=ODK7wY_3m4B66o0LqJi9aK2PEfHha4q68nA@mail.gmail.com>
References: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
	<1525176522-200354-5-git-send-email-imammedo@redhat.com>
	<CAFEAcA8iq9gJuC=ODK7wY_3m4B66o0LqJi9aK2PEfHha4q68nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] arm: boot: set boot_info starting
 from first_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On Tue, 1 May 2018 13:19:12 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 1 May 2018 at 13:08, Igor Mammedov <imammedo@redhat.com> wrote:
> > even though nothing is currently broken, make sure that boot_info
> > is set on all CPUs.
> >
> > Ref:
> > "Message-ID: <CAFEAcA_NMWuA8WSs3cNeY6xX1kerO_uAcN_3=fK02BEhHJW86g@mail.gmail.com>"  
> 
> Can you include the rationale in the commit message rather
> than just pointing to a message-id, please?
sure,
I'll post it  reply here.

BTW: I'm expecting this being merged through ARM tree 

> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > --  
> 
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
