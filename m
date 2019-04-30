Received: from eggs.gnu.org ([209.51.188.92]:57114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLbgi-00019q-1O
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:57:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hLbfY-0008Tx-Rw
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:56:13 -0400
References: <20190426221528.30293-1-jsnow@redhat.com>
	<20190426221528.30293-3-jsnow@redhat.com>
	<20190429134454.GB4675@paraplu>
From: John Snow <jsnow@redhat.com>
Message-ID: <a9e5880b-cc9a-6f1e-3a6d-b1db09f1c895@redhat.com>
Date: Tue, 30 Apr 2019 18:56:08 -0400
MIME-Version: 1.0
In-Reply-To: <20190429134454.GB4675@paraplu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] docs/interop/bitmaps: rewrite and
 modernize doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, vsementsov@virtuozzo.com, armbru@redhat.com, aliang@redhat.com, nsoffer@redhat.com, Fam Zheng <fam@euphon.net>, qemu-stable@nongnu.org, eblake@redhat.com



On 4/29/19 9:44 AM, Kashyap Chamarthy wrote:
> On Fri, Apr 26, 2019 at 06:15:28PM -0400, John Snow wrote:
>> This just about rewrites the entirety of the bitmaps.rst document to
>> make it consistent with the 4.0 release. I have added new features seen
>> in the 4.0 release, as well as tried to clarify some points that keep
>> coming up when discussing this feature both in-house and upstream.
>>
>> Yes, it's a lot longer, mostly due to examples. I get a bit chatty.
>> I could use a good editor to help reign in my chattiness.
>>
>> It does not yet cover pull backups or migration details, but I intend to
>> keep extending this document to cover those cases.
>>
>> Please try compiling it with sphinx and look at the rendered output, I
>> don't have hosting to share my copy at present. 
> 
> FWIW, here's a public rendering (with the "Alabaster" Sphinx theme) with
> your v3 applied:
> 
>     https://kashyapc.fedorapeople.org/QEMU-Docs-v4.0.0-143-g1cb2ca0415/_build/html/docs/interop/bitmaps.html
> 

Thank you!! We really need to figure out hosting for these.

> Thanks for the overhaul.  Afraid, I've been just too swamped to be able
> to look at this in detail, much as I'd love to.  I will slowly catch up.
> 
>     - - -
> 
> (Note to self: send to the list the text-to-rST converted QEMU docs
> sitting locally on a Git branch.)
> 

PLEASE do! Please CC me on them. I realize it's not a priority for you
at the moment but I will happily take any existing work you've done.

> [...]
> 
>> I think this new layout reads nicer in the HTML format than the old
>> one did, at the expense of looking less readable in the source tree
>> itself (though not completely unmanagable. We did decide to convert it
>> from Markdown to ReST, after all, so I am going all-in on ReST.)
> 
> [...]
> 
