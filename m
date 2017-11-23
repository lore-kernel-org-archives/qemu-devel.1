Received: from eggs.gnu.org ([2001:4830:134:3::10]:41845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eHswy-0002tm-Dn
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 09:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eHswx-0000im-Kb
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 09:58:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eHswx-0000fx-Do
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 09:57:59 -0500
Date: Thu, 23 Nov 2017 15:57:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171123155751.4495e63b@redhat.com>
In-Reply-To: <6dd7061e-2ebe-7a51-8142-f67d5d75a81a@redhat.com>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<20171123110345.03541b50.cohuck@redhat.com>
	<CAFEAcA83-oqifsZboJmvDVYhhr4=QOEEGF1TZba-jCewpUFtyg@mail.gmail.com>
	<1dff6d6c-be83-f6e1-2b7e-82d98bdb8a63@redhat.com>
	<6dd7061e-2ebe-7a51-8142-f67d5d75a81a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 23 Nov 2017 12:17:54 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 23/11/2017 11:57, Thomas Huth wrote:
> > On 23.11.2017 11:17, Peter Maydell wrote:  
> >> On 23 November 2017 at 10:03, Cornelia Huck <cohuck@redhat.com> wrote:  
> >>> On Mon, 13 Nov 2017 08:14:28 +0100
> >>> Thomas Huth <thuth@redhat.com> wrote:
> >>>  
...  
> 
> "hax" is very far from feature parity with TCG, it doesn't even support
> CPUID (-cpu).  "-accel kvm:hvf:tcg" could be a possibility, but only if
> we have resources to test it.  As far as I know the only active x86
> developer who owns a Mac is Igor?
I can test occasionally but hw is out warranty so no hard promises from me to do it.

> Paolo
> 
> 
